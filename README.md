Philographer
============

[![Build Status](https://travis-ci.org/r2practice/philographer.png)](https://travis-ci.org/r2practice/philographer)
A super simple gem for interfacing w/ the DocuSign REST API and possibly a parser for their callback posts on document changes.

## Development Caveats

Since this project is designed to interface with a private web API and the
authentication information for the API is the same for both testing and
production environments we can't very well share our credentials with the world.
To enable users without credentials (for whatever reason) to hack on ths and
prevent constant API requests during testing we're doing some slightly different
things. First we're using VCR to playback requests (not so odd). Second, we've
provided facilities for developers needing to record new request types to use
their own credentials to hit the real API.

To put your own credentials simply supply them in the ```spec``` directory in
a file named ```credentials.yml``` that has four fields:

```yaml
---
username: your_username (email or a UUID like string)
password: your_password
integrator_key: your_integrator_key
account_id: your_account_id
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
