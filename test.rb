 path = "system.conf"
 query = 'DefaultEnvironment'
 file = File.readlines(path)
 matches = file.select { |name| name[/#{query}/i] }
 matches.push()
 line = matches[0]
 vars = line.split('=',2)[1]
 listvars = vars.split(" ")

 def delete_env_var(var,value,listvars)
     listvars.delete('"'+var+'='+value+'"')  
 return listvars    
 end    


print exists("test","test",listvars)

   def exists(var,value,listvars)
       if listvars.include?('"'+var+'='+value+'"')
          return true
       else
          return false
       end
   end
