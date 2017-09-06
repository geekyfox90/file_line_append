Puppet::Type.newtype(:service_env_var) do
    
      ensurable
          
      newparam(:name) do
          desc "The name of the variable."
      end
      newparam(:value) do
          desc "The value of the env variable."
      end
    end