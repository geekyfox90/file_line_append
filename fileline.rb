Puppet::Type.type(:service_env_var).provide(:ruby) do   
    
   path = "system.conf"
   query = 'DefaultEnvironment'
   file = File.readlines(path)
   matches = file.select { |name| name[/#{query}/i] }
   matches.push()
   line = matches[0]
   vars = line.split('=',2)[1]
   listvars = vars.split(" ")    
    
   def exists?
       exists(resource[:name],resource[:value],listvars) 
   end
    
   def create
     listvars = add_env_var(resource[:name],resource[:value],listvars)    
     newline = query+"="+listvars.join(" ")+"\n"
     file = File.read(path)
     new_contents = file.gsub(line, newline)
     File.open(path, "w") {|file| file.puts new_contents }
  end

  def destroy
      listvars = destroy_env_var(resource[:name],resource[:value],listvars)    
     newline = query+"="+listvars.join(" ")+"\n"
     file = File.read(path)
     new_contents = file.gsub(line, newline)
     File.open(path, "w") {|file| file.puts new_contents }
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


#handle_append_line
