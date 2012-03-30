module DataFilesHelper

  def read_data_file(file_name)
    result = []
    File.open(Rails.root.to_s + '/features/' + file_name).readlines.each do |line|
      result << normalize(line)
    end
    result
  end

  def load_data(file_key, file_name)
    @file_cache = {} unless @file_cache
    @file_cache[file_key] ||= read_data_file(file_name)
  end
  
  def file_data_helper(file_key)
    @file_cache[file_key]
  end
  
private
  def normalize(line)
    #value = value.force_encoding("ASCII")
    line.chomp.encode("ASCII", :undef => :replace)    
  end

end

World(DataFilesHelper)