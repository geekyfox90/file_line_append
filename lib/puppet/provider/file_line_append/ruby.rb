Puppet::Type.type(:file_line_append).provide(:ruby) do 
    
   $path = "/etc/systemd/system.conf"
   $query = 'DefaultEnvironment'
       
   def exists?
      listvars = init()
      exists(resource[:name],resource[:value],listvars) 
   end
    
   def create
     listvars = init()   
     listvars = add_env_var(resource[:name],resource[:value],listvars)    
     newline = $query+"="+listvars.join(" ")+"\n"
     file = File.read($path)
     new_contents = file.gsub($line, newline)
     File.open($path, "w") {|file| file.puts new_contents }
  end
 
  def destroy
     listvars = init()  
     listvars = destroy_env_var(resource[:name],resource[:value],listvars)    
     newline = $query+"="+listvars.join(" ")+"\n"
     file = File.read($path)
     new_contents = file.gsub($line, newline)
     File.open($path, "w") {|file| file.puts new_contents }    
  end    
    
 def init()
   file = File.readlines($path)
   matches = file.select { |name| name[/#{$query}/i] }
   matches.push()
   $line = matches[0]
   if matches[1]
       $line = matches[1]
       file = File.read($path)
       new_contents = file.gsub(matches[0], "")
       File.open($path, "w") {|file| file.puts new_contents }
   end    
      vars = $line.split('=',2)[1]
      listvars = vars.split(" ") 
      return listvars 
 end     
    
 def add_env_var(var,value,listvars)
   found = false    
   listvars = listvars.map do |var_|
     if var_.include?(var+"=")  
        found = true
        '"'+var+'='+value+'"'
     else
        var_
     end
   end
   if (!found) 
      listvars.push('"'+var+'='+value+'"')
   end    
 return listvars    
 end    
 
 def destroy_env_var(var,value,listvars)
     listvars.delete('"'+var+'='+value+'"')  
     return listvars    
 end    
    
 def exists(var,value,listvars)
    if listvars.include?('"'+var+'='+value+'"')
        return true
    else
        return false
    end
 end
       
end