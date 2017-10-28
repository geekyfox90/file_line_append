Puppet::Type.newtype(:file_line_append) do
    
      ensurable
          
      newparam(:name) do
          desc "The name of the variable."
      end
      newparam(:value) do
          desc "The value of the env variable."
      end
    end