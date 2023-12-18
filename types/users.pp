# Configuration for multiple users
type Htop::Users = Hash[
  String[1],
  Struct[{
    Optional[options]  => Htop::Conf,
    Optional[replace]  => Boolean,
    Optional[defaults] => Htop::Conf,
    Optional[screens] => Htop::Screens,
  }],
]
