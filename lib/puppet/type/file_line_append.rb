Puppet::Type.newtype(:file_line_append) do

  desc <<-EOT
    Ensures that a given string is contained within a line in a file.  If
    the string is not contained in the given line, Puppet will append the string to
    the end of the line to ensure the desired state. 
    Example:
       file_line_append { 'sudo_rule':
          path => '/etc/sudoers',
          line => '%sudo ALL=(ALL)',
          string => ' /usr/bin/myscript2'
        }
     Match example:
        file_line_append { 'sudo_rule':
          path => '/etc/sudoers',
          line => '%sudo ALL=(ALL)',
          string => '/usr/bin/myscript',
          match => '/usr/bin/notworkingscript'
        }
     In this code example math will look for a line beginning with %sudo and then look for a match string a replace it with the string value.
  EOT

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

  validate do
    unless self[:path]
      raise(Puppet::Error, "path is a required attribute")
    end
    unless self[:string]
      raise(Puppet::Error, "string is a required attribute")
    end
    unless self[:line]
      raise(Puppet::Error, "line is a required attribute")
    end
  end

end