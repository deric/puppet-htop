# Screen
type Htop::Screen = Struct[{
  name             => String[1],
  header           => String[1],
  Optional[config] => Htop::Conf,
}]
