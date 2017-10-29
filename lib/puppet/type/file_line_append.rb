Puppet::Type.newtype(:file_line_append) do
    
       ensurable do
          defaultvalues
          defaultto :present
       end
    
       newparam(:name, :namevar => true) do
           desc 'An arbitrary name used as the identity of the resource.'
       end
          
       newparam(:string) do
           desc "The string to be appended to the line or used to replace matches found by the match attribute."
       end
       newparam(:path) do
          desc 'The file Puppet will ensure contains the line specified by the line parameter.'
          validate do |value|
           unless Puppet::Util.absolute_path?(value)
               raise Puppet::Error, "File paths must be fully qualified, not '#{value}'"
           end
        end
       end
       newparam(:match) do
           desc 'an option string to be used to repalce the string found, if not specified, the new string will be appended at the end of the line.'
       end

       newparam(:line) do
           desc 'The line where the string will be appended.'
       end
    
end