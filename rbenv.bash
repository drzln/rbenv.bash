################################################################################
# rbenv helper functions
################################################################################

provision:rbenv:version() {
	if [ -f ~/.rbenv/bin/rbenv ]; then
		! [ -d "$HOME/.rbenv/versions/$(cat .ruby-version)" ] && rbenv install
	fi
}

provision:rbenv:gemset() {
	if [ -f Gemfile ]; then
		! [ -d "$HOME/.rbenv/versions/$(cat .ruby-version)/gemsets/$(cat .ruby-gemset)" ] && gem install bundler && bundle
	fi
}

provision:rbenv:yard:gems() {
	if [ -f "$HOME/.rbenv/versions/$(cat .ruby-version)/gemsets/$(cat .ruby-gemset)/bin/yard" ]; then
		! [ -d "$HOME/.rbenv/versions/$(cat .ruby-version)/gemsets/$(cat .ruby-gemset)/doc" ] && yard gems
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
