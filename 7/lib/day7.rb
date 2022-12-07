input = File.read(File.join(__dir__, './input.txt'))

def prepare_input(input)
  filesystem = {'/' => { files: {} }}

  dir_history = ['/']

  input.lines.each do |line|
    line.chomp!
    if line.start_with?('$ cd ..')
      dir_history.pop # move to dir up
    elsif line.start_with?('$ cd /')
      dir_history = ['/'] # mode to home
    elsif line.start_with?('$ cd')
      dir_history << line[5..] # move to child dir
    elsif line.start_with?('dir')
      dir_name = line[4..]
      unless dir_history.inject(filesystem, :[])[dir_name]
        dir_history.inject(filesystem, :[])[dir_name] = {files: {}}
      end
    elsif !line.start_with?('$ ls')
      file = line.split
      dir_history.inject(filesystem, :[])[:files][file[1]] = file[0].to_i
    end
  end
  filesystem
end

def calculate_directory_size(directory, sum = 0)
  sum = directory[:files].values.sum
  return sum if directory.length == 1

  directory.keys.each do |key|
    if key != :files
      sum += calculate_directory_size(directory[key], sum)
    end
  end
  sum
end

def calculate_total_size(directory, sum = 0)
  dir_size = calculate_directory_size(directory)
  sum += dir_size if dir_size <= 100000
  return sum if directory.length == 1

  directory.each do |key, child_dir|
    sum = calculate_total_size(child_dir, sum) if key != :files
  end
  sum
end

def calculate_all_directories(directory, sizes = {})
  return sizes if directory.keys == [:files]

  directory.each do |key, child_dir|
    if key != :files
      sizes[key] = calculate_directory_size(child_dir)
      calculate_all_directories(child_dir, sizes)
    end
  end
  sizes
end

def solve1(input)
  filesystem = prepare_input(input)
  calculate_total_size(filesystem['/'])
end

def solve2(input)
  filesystem = prepare_input(input)
  sizes = calculate_all_directories(filesystem)
  total_size = sizes['/']
  unused_space = 70000000 - total_size
  required_space = 30000000 - unused_space
  sizes.select { |key, value| value >= required_space }.min {|pair1, pair2| pair1[1] <=> pair2[1] }[1]
end

# p solve1(input)
# p solve2(input)
