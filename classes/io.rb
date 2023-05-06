require 'json'
require_relative '../classes/item'
require_relative '../classes/genre'
require_relative '../classes/music'

module IOHelper
  def write_file(obj, filename)
    json = obj.map(&:to_json)
    File.write(filename, json, mode: 'w')
  end

  def read_file(filename, class_name)
    if File.exist?(filename) and File.size(filename).positive?
      json = File.read(filename, mode: 'r')
      JSON.parse(json).map { |obj| Object.const_get(class_name).from_json(obj) }
    else
      []
    end
  end
end
