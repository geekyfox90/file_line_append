$path = "file"
$regex = "^test"
$string = "thinking"
$match = "nothinking"
$present = false


def getline()
   file = File.readlines($path)
   matches = file.select { |line| line.match($regex) }
   line = matches[0]
   return line
end    

def exists(line)
    if line.include? $string
        return true
    else
        return false
    end
end

def add_string(line)
    if ($match)
        line = line.gsub($match,$string)    
    else
     if line.include? "\n"
        line = line.gsub(/\n/,"")
        $string << "\n"    
     end  
     line << $string
    end
    return line
end   

def delete_string(line) 
    line = line.gsub($string,"")
    return line
end


myline = getline()
newline = add_string(myline)
file = File.read($path)
new_contents = file.gsub(myline, newline)
File.open($path, "w") {|file| file.puts new_contents }
