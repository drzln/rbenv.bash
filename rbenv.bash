################################################################################
# rbenv helper functions
################################################################################


provision:resolve:ruby:version() {
	if [ -f .ruby-version ];
	then
		__rbenv_ruby_version=$(cat .ruby-version)
	else
		__rbenv_ruby_version="2.7.5"
	fi
}

provision:resolve:ruby:gemset() {
	if [ -f .ruby-gemset ];
	then
		__rbenv_ruby_gemset=$(cat .ruby-gemset)
	else
		__rbenv_ruby_gemset="default_provisioner_gemset_name"
	fi
}

provision:resolve:globals() {
	provision:resolve:ruby:version
	provision:resolve:ruby:gemset
	export __rbenv_home="$HOME/.rbenv"
	export __rbenv_versions="$__rbenv_home/versions"
	export __rbenv_bin="$__rbenv_home/bin/rbenv"
	export __rbenv_gemsets="$__rbenv_versions/$__rbenv_ruby_version/gemsets"
	export __rbenv_gemset="$__rbenv_versions/$__rbenv_ruby_version/gemsets/$__rbenv_ruby_gemset"
	export __rbenv_yard="$__rbenv_gemset/bin/yard"
	export __rbenv_yard_doc="$__rbenv_gemset/doc"
}

provision:disolve:globals() {
	unset __rbenv_ruby_version
	unset __rbenv_ruby_gemset
	unset __rbenv_home
	unset __rbenv_versions
	unset __rbenv_bin
	unset __rbenv_gemsets
	unset __rbenv_gemset
	unset __rbenv_yard
	unset __rbenv_yard_doc
}

provision:before() {
	provision:resolve:globals
}

provision:after() {
	provision:disolve:globals
}

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
	provision:before
	provision:rbenv:version
	provision:rbenv:gemset
	provision:rbenv:yard:gems
	provision:after
}

direnv:auto:rbenv() {
	provision:rbenv:full
}

############################################################################## @
