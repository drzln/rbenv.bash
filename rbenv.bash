################################################################################
# rbenv helper functions
################################################################################

__rbenv_home="$HOME/.rbenv"
__rbenv_versions="$__rbenv_home/versions"
__rbenv_bin="$__rbenv_home/bin/rbenv"
__rbenv_ruby_version=$(cat .ruby-version)
__rbenv_ruby_gemset=$(cat .ruby-gemset)
__rbenv_gemsets="$__rbenv_versions/$__rbenv_ruby_version/gemsets"
__rbenv_gemset="$__rbenv_versions/$__rbenv_ruby_version/gemsets/$__rbenv_ruby_gemset"
__rbenv_yard="$__rbenv_gemset/bin/yard"
__rbenv_yard_doc="$__rbenv_gemset/doc"

provision:rbenv:version() {
	if [ -f $__rbenv_bin ]; then
		! [ -d "$__rbenv_versions/$__rbenv_ruby_version" ] && $__rbenv_bin install
	fi
}

provision:rbenv:gemset() {
	if [ -f Gemfile ]; then
		! [ -d "$__rbenv_gemset" ] && gem install bundler && bundle
	fi
}

provision:rbenv:yard:gems() {
	if [ -f "$__rbenv_yard" ]; then
		! [ -d "$__rbenv_yard_doc" ] && yard gems
	fi
}

provision:rbenv:full() {
	provision:rbenv:version
	provision:rbenv:gemset
	provision:rbenv:yard:gems
}

direnv:auto:rbenv() {
	provision:rbenv:full
}

############################################################################## @
