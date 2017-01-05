# acmesmith-http-path

This gem is a plugin for [Acmesmith](https://github.com/sorah/acmesmith)
and implements an automated `http-01` challenge responder.

## Usage ### Prerequisites
- You need to have write access to the docroot of your webserver vhost

### Installation Install `acmesith-http-path` gem along with
`acmesmith`. You can just do `gem install acmesith-http-path` or use
Bundler if you want.

### Configuration Use `http_path` challenge responder in your
`acmesmith.yml`. General instructions about `acmesmith.yml` is available
in the manual of Acmesmith.

In the configuration you need to configure every domain seperately. The
`htdocs_path` key should point to the root path of your domain website.

```yaml
endpoint: https://acme-v01.api.letsencrypt.org/

storage:
  type: filesystem
  path: /path/to/key/storage

challenge_responders:
  - http_path:
      "domain-one.com":
        htdocs_path: /var/www/domain-one.com/public_html
      "second-domain.com":
        htdocs_path: /var/www/second-domain.com/public_html
```

you may want to use the post_issueing_hooks configuration to copy
the certificates to the correct location and perhaps reload the webserver
configuration.

### Domain authorization and certificate requests

You are instructed how to use Acmesmith in its documentaion. Here are
just example command lines to authorize `domain-one.com` and request a
certificate for it.

```sh
vi acmesmith.yml
acmesmith register mailto:your.mail.address@example.net
acmesmith authorize domain-one.com
acmesmith request domain-one.com
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/acmesmith-http-path. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

