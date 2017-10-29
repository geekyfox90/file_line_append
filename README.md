# file_line_append

The module provides a resouce file_line_append which can be used to ensure that a given string is contained within a line in a file.  If the string is not contained in the given line, Puppet will append the string to the end of the line to ensure the desired state. 

Example:

```
file_line_append { 'sudo_rule':
   path => '/etc/sudoers',
   line => '%sudo ALL=(ALL)',
   string => ' /usr/bin/myscript2'
}
```

Match example:
 
``` 
file_line_append { 'sudo_rule':
   path => '/etc/sudoers',
   line => '%sudo ALL=(ALL)',
   string => '/usr/bin/myscript',
   match => '/usr/bin/notworkingscript'
}
```

In this code example match will look for a line beginning with %sudo and then look for a match string a replace it with the string value.

This resource looks like the file_line resource provided by the stdlib module. but it helps you manage lines instead of files and append strings to a given line more easily.

I made a pull request to the stdlib module to add this resource, while waiting you can use this module.