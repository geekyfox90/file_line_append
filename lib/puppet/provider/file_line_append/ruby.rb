Puppet::Type.type(:file_line_append).provide(:ruby) do

  def exists?
    line = getline()
    exists(line)
  end

  def create
    line = getline()
    newline = add_string(line)
    file = File.read(resource[:path])
    new_contents = file.gsub(line, newline)
    File.open(resource[:path], "w") {|file| file.puts new_contents}
  end

  def destroy
    line = getline()
    newline = delete_string(line)
    file = File.read(resource[:path])
    new_contents = file.gsub(line, newline)
    File.open(resource[:path], "w") {|file| file.puts new_contents}
  end

  def getline()
    file = File.readlines(resource[:path])
    matches = file.select {|line| line.match(resource[:line])}
    line = matches[0]
    return line
  end

  def exists(line)
    if line.include? resource[:string]
      return true
    else
      return false
    end
  end

  def add_string(line)
    if (resource[:match])
      line = line.gsub(resource[:match], resource[:string])
    else
      if line.include? "\n"
        line = line.gsub(/\n/, "")
        resource[:string] << "\n"
      end
      line << resource[:string]
    end
    return line
  end

  def delete_string(line)
    line = line.gsub(resource[:string], "")
    return line
  end

end