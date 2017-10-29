class file_line_append::init {

  file_line_append {'test file line append':
       ensure => present,
       file => "",
       name => "test",
       value => "test"
  }

}