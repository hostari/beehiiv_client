class Beehiiv::List(T)
  include JSON::Serializable
  include Enumerable(T)

  getter data : Array(T)
  getter limit : Int32?
  getter page : Int32?
  getter total_results : Int32?
  getter total_pages : Int32?

  def each(&block)
    data.each do |i|
      yield i
    end
  end
end
