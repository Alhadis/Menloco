#!/bin/sh

#
# Prints an NPM-style dependency tree
#

# Squash the internal field separator
IFS=

read -r -d '' VAR <<EOF
└─┬ chalk@1.1.1 
  ├── babel@6.0.14
  ├─┬ commander@2.9.0
  │ └── graceful-readlink@1.0.1
  ├─┬ es6-module-loader@0.17.8
  │ └── when@3.7.3
  ├─┬ jsdom@7.0.2
  │ ├── abab@1.0.0
  │ ├── acorn@2.4.0
  │ ├── acorn-globals@1.0.6
  │ ├── browser-request@0.3.3
  │ ├── cssom@0.3.0
  │ ├── cssstyle@0.2.29
  │ ├─┬ escodegen@1.7.0
  │ │ ├── esprima@1.2.5
  │ │ ├── estraverse@1.9.3
  │ │ ├── esutils@2.0.2
  │ │ ├─┬ optionator@0.5.0
  │ │ │ ├── deep-is@0.1.3
  │ │ │ ├── fast-levenshtein@1.0.7
  │ │ │ ├── levn@0.2.5
  │ │ │ ├── prelude-ls@1.1.2
  │ │ │ ├── type-check@0.3.1
  │ │ │ └── wordwrap@0.0.3
  │ │ └─┬ source-map@0.2.0
  │ │   └── amdefine@1.0.0
  │ ├─┬ htmlparser2@3.8.3
  │ │ ├── domelementtype@1.3.0
  │ │ ├── domhandler@2.3.0
  │ │ ├─┬ domutils@1.5.1
  │ │ │ └─┬ dom-serializer@0.1.0
  │ │ │   ├── domelementtype@1.1.3
  │ │ │   └── entities@1.1.1
  │ │ ├── entities@1.0.0
  │ │ └─┬ readable-stream@1.1.13
  │ │   ├── core-util-is@1.0.1
  │ │   ├── inherits@2.0.1
  │ │   ├── isarray@0.0.1
  │ │   └── string_decoder@0.10.31
  │ ├── nwmatcher@1.3.6
  │ ├── parse5@1.5.0
  │ ├─┬ request@2.65.0
  │ │ ├── aws-sign2@0.6.0
  │ │ ├─┬ bl@1.0.0
  │ │ │ └─┬ readable-stream@2.0.2
  │ │ │   ├── process-nextick-args@1.0.3
  │ │ │   └── util-deprecate@1.0.2
  │ │ ├── caseless@0.11.0
  │ │ ├─┬ combined-stream@1.0.5
  │ │ │ └── delayed-stream@1.0.0
  │ │ ├── extend@3.0.0
  │ │ ├── forever-agent@0.6.1
  │ │ ├─┬ form-data@1.0.0-rc3
  │ │ │ └── async@1.4.2
  │ │ ├─┬ har-validator@2.0.2
  │ │ │ ├─┬ chalk@1.1.1
  │ │ │ │ ├── ansi-styles@2.1.0
  │ │ │ │ ├── escape-string-regexp@1.0.3
  │ │ │ │ ├─┬ has-ansi@2.0.0
  │ │ │ │ │ └── ansi-regex@2.0.0
  │ │ │ │ ├── strip-ansi@3.0.0
  │ │ │ │ └── supports-color@2.0.0
  │ │ │ ├─┬ is-my-json-valid@2.12.2
  │ │ │ │ ├── generate-function@2.0.0
  │ │ │ │ ├─┬ generate-object-property@1.2.0
  │ │ │ │ │ └── is-property@1.0.2
  │ │ │ │ ├── jsonpointer@2.0.0
  │ │ │ │ └── xtend@4.0.0
  │ │ │ └─┬ pinkie-promise@1.0.0
  │ │ │   └── pinkie@1.0.0
  │ │ ├─┬ hawk@3.1.0
  │ │ │ ├── boom@2.9.0
  │ │ │ ├── cryptiles@2.0.5
  │ │ │ ├── hoek@2.16.3
  │ │ │ └── sntp@1.0.9
  │ │ ├─┬ http-signature@0.11.0
  │ │ │ ├── asn1@0.1.11
  │ │ │ ├── assert-plus@0.1.5
  │ │ │ └── ctype@0.5.3
  │ │ ├── isstream@0.1.2
  │ │ ├── json-stringify-safe@5.0.1
  │ │ ├─┬ mime-types@2.1.7
  │ │ │ └── mime-db@1.19.0
  │ │ ├── node-uuid@1.4.3
  │ │ ├── oauth-sign@0.8.0
  │ │ ├── qs@5.2.0
  │ │ ├── stringstream@0.0.4
  │ │ └── tunnel-agent@0.4.1
  │ ├── symbol-tree@3.1.3
  │ ├── webidl-conversions@2.0.0
  │ ├─┬ whatwg-url-compat@0.6.5
  │ │ └── tr46@0.0.2
  │ └── xml-name-validator@2.0.1
  ├─┬ node-fetch@1.3.3
  │ └─┬ encoding@0.1.11
  │   └── iconv-lite@0.4.13
  └── tough-cookie@2.2.0


EOF

echo $VAR;
