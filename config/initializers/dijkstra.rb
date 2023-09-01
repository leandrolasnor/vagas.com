# frozen_string_literal: true

class Dijkstra
  extend Dry::Initializer

  param :edges

  option :map, default: -> { map_vertices }
  option :no_of_vertices, default: -> { map.count }

  option :weight, default: -> { Array.new(no_of_vertices) { Float::INFINITY } }
  option :parent, default: -> { Array.new(no_of_vertices) }
  option :adjacent, default: -> { Array.new(no_of_vertices) { Array.new(no_of_vertices) { false } } }
  option :graph, default: -> { Array.new(no_of_vertices) { Array.new(no_of_vertices) { 0 } } }

  def call(origin, destination)
    traced = Tracing.new(origin, destination)

    adjacent = adjacent_matrix
    graph = graph_matrix

    origin = map[origin]
    destination = map[destination]

    chosen = origin
    weight[origin] = 0

    while chosen != destination
      adjacent[chosen].each_with_index do |neighbor, i|
        next if !neighbor || weight[i].nil?

        new_weight = weight[chosen] + graph[chosen][i]
        if new_weight < weight[i]
          weight[i] = new_weight
          parent[i] = chosen
        end
      end

      weight[chosen] = nil
      chosen = weight.index(weight.min_by { _1.nil? ? Float::INFINITY : _1 })
    end

    traced.distance = weight[destination]
    current = destination

    until current.nil?
      traced.path.unshift(map.key(current))
      current = parent[current]
    end

    traced
  end

  class ::Tracing
    extend Dry::Initializer
    attr_writer :distance
    attr_writer :path

    param :origin
    param :destination

    option :starting_point, default: -> { origin }
    option :ending_point, default: -> { destination }
    option :distance, default: -> { 0 }
    option :path, default: -> { [] }
  end

  private

  def map_vertices
    result = {}
    vertices = (edges.pluck(0) + edges.pluck(1)).uniq.sort
    vertices.length.times do |i|
      result[vertices[i]] = i
    end

    result
  end

  def adjacent_matrix
    edges.each do |edge|
      adjacent[map[edge[0]]][map[edge[1]]] = true
      adjacent[map[edge[1]]][map[edge[0]]] = true
    end

    adjacent
  end

  def graph_matrix
    edges.each do |edge|
      graph[map[edge[0]]][map[edge[1]]] = edge[2]
      graph[map[edge[1]]][map[edge[0]]] = edge[2]
    end

    graph
  end
end

Rails.cache.fetch(:edges) do
  [
    ['A', 'B', 5],
    ['B', 'C', 7],
    ['C', 'E', 4],
    ['E', 'D', 10],
    ['D', 'B', 3],
    ['D', 'F', 8]
  ]
end
