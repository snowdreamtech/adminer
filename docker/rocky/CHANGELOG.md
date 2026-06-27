# Changelog

## [5.4.2](https://github.com/snowdreamtech/adminer/compare/rocky-v5.4.2...rocky-v5.4.2) (2026-06-27)


### 🚀 Features

* auto-load all adminer plugins dynamically via index.php ([a1ac2c5](https://github.com/snowdreamtech/adminer/commit/a1ac2c5fa426b305c6d68dfbeb3f8ebf9c6ffc41))
* Declare ADMINER_DEFAULT_SERVER_MODE in Dockerfiles ([d85418c](https://github.com/snowdreamtech/adminer/commit/d85418cfdcd065d313eeca0e4ef08db5c1d2e39c))
* Enable AdminerLoginServers plugin to avoid manual server input ([c718887](https://github.com/snowdreamtech/adminer/commit/c7188877221ceb73d677001ae075f25f08921120))
* **plugins:** add MongoDB driver support to login servers ([50f779a](https://github.com/snowdreamtech/adminer/commit/50f779a9fbc5ffcb6c38750ca8fac6adbd6b624e))
* restore commented AdminerLoginServers configuration example ([ff568e6](https://github.com/snowdreamtech/adminer/commit/ff568e637a7acc537426967b45b2a7ede5e0cda9))
* Support pure-PHP drivers (ClickHouse, Elasticsearch, SimpleDB, IGDB) out of the box ([e3a5a3e](https://github.com/snowdreamtech/adminer/commit/e3a5a3e7dc391de6553e1cfbbe0a3a505ee3bff5))
* Support toggling login server mode via ADMINER_DEFAULT_SERVER_MODE env var ([6e5287d](https://github.com/snowdreamtech/adminer/commit/6e5287d74a895873cd1b17a7fc3e7c6e44d5c039))


### 🐛 Bug Fixes

* **docker:** fix Adminer plugin instantiation syntax and include plugin.php ([912a5dd](https://github.com/snowdreamtech/adminer/commit/912a5dddbd5b293cc82b514739a29ecd70a361ec))
* Generate relative URLs for adminer designs ([7848a31](https://github.com/snowdreamtech/adminer/commit/7848a314c5c3a26e3ea9fa4667d8f2bafac50f32))
* Only auto-load specific plugins instead of all plugins blindly ([c9ddb31](https://github.com/snowdreamtech/adminer/commit/c9ddb3186f1967fd603082d0f6dc1a9b77dea777))
* **plugins:** fix Adminer 5.x theme switching and plugin loading ([7015e42](https://github.com/snowdreamtech/adminer/commit/7015e42bce355b1da2b91096504989c78f6ba535))
* Update plugin loading for Adminer 5.x compatibility ([0d448b7](https://github.com/snowdreamtech/adminer/commit/0d448b79fbad0de0d6d10a9004b28e564343540e))


### 🛠 Refactoring

* **docker:** align Dockerfiles with base image structure ([232574f](https://github.com/snowdreamtech/adminer/commit/232574fed8418f8c7f257d001e951361dfa467a0))
* migrate Dockerfiles to dev skeleton and update adminer versions ([5a27404](https://github.com/snowdreamtech/adminer/commit/5a274049c33b6571556f1e681244c128cd64551f))
* remove redundant docker-entrypoint.sh files ([87c576b](https://github.com/snowdreamtech/adminer/commit/87c576b27731ad11c5bc0ebc661e07c5a09ff1c1))
* reorganize distribution variants into docker directory ([67a8c91](https://github.com/snowdreamtech/adminer/commit/67a8c911e21801bf12b3e83d02e22f3b3f59a2ba))


### 📖 Documentation

* add detailed comments to entrypoint initialization scripts ([f42cbaa](https://github.com/snowdreamtech/adminer/commit/f42cbaab6edfbc5c38c2a636dfd8651fea900940))


### ♻️ Miscellaneous Chores

* clear previous changelog entries ([4130cb5](https://github.com/snowdreamtech/adminer/commit/4130cb5fe99115a60c1af64ce75a078962f41fc8))
* **deps:** bump base images to alpine 3.24.0, debian 13.5.0, rocky 10.2.0 ([1688969](https://github.com/snowdreamtech/adminer/commit/168896956d2f4c7f91309c4c98ffef36ca7e8546))
* release main ([deb8454](https://github.com/snowdreamtech/adminer/commit/deb8454df7518d56939ab3851245a4cd7b03d709))
* release main ([d87cb81](https://github.com/snowdreamtech/adminer/commit/d87cb815685ad9b5b43d4b9a195c68dee2fd8065))
* release main ([78328d2](https://github.com/snowdreamtech/adminer/commit/78328d20bd3697d48ea90aee8d0eaa6af4ccc09c))
* release main ([b720ad5](https://github.com/snowdreamtech/adminer/commit/b720ad57dd1691d8ae07dcac7d46d0bd257af3a0))
* release main ([32dd84d](https://github.com/snowdreamtech/adminer/commit/32dd84de4be973395d0867b5d527d528948a35df))
* release main ([725c69f](https://github.com/snowdreamtech/adminer/commit/725c69fdcc222b5b83d0690629ce213a68c586ab))
* release main ([070b694](https://github.com/snowdreamtech/adminer/commit/070b694a702763b60fc6b057a81418320418cafa))
* release main ([36d1211](https://github.com/snowdreamtech/adminer/commit/36d1211036847a8c6aaa01a21a1c695a47b71d45))
* release main ([9ad4f94](https://github.com/snowdreamtech/adminer/commit/9ad4f9490832efdc310f2ebbd8c77f3404daf07f))
* release main ([b0684a3](https://github.com/snowdreamtech/adminer/commit/b0684a32a652e83506451e6056168cfec8b9142c))
* release main ([495e18a](https://github.com/snowdreamtech/adminer/commit/495e18a4babcb06a12c2f5aec9ea571d97cb32e3))
* release main ([d4a3a34](https://github.com/snowdreamtech/adminer/commit/d4a3a34b00a6b9f381cd5d556749c257516b2f08))
* release main ([28d9426](https://github.com/snowdreamtech/adminer/commit/28d94263f4374017274707faef7183917b689be9))
* **release:** deduplicate CHANGELOG headers ([d47fb44](https://github.com/snowdreamtech/adminer/commit/d47fb44cb105b368722d7d0e210a27b525f82d87))
* **release:** deduplicate CHANGELOG headers ([e795177](https://github.com/snowdreamtech/adminer/commit/e79517795d98b9f8292ef956586a6dc03932d03c))
* **release:** deduplicate CHANGELOG headers ([27919e4](https://github.com/snowdreamtech/adminer/commit/27919e4baf4aab5b2a2bf32a7d437b05a717c11b))
* **release:** deduplicate CHANGELOG headers ([438190d](https://github.com/snowdreamtech/adminer/commit/438190d297c151c75eca4912fdc22c285d5ec1ea))
* **release:** deduplicate CHANGELOG headers ([256f043](https://github.com/snowdreamtech/adminer/commit/256f04311b2344f2648ca5bcf407146f8c690258))
* **release:** deduplicate CHANGELOG headers ([d263aae](https://github.com/snowdreamtech/adminer/commit/d263aae7b223103a01dd0e114430381c5d863dd7))
* **release:** deduplicate CHANGELOG headers ([133954e](https://github.com/snowdreamtech/adminer/commit/133954e95cfae85cbba2fb9c1ac5acbc677ca39d))
* **release:** deduplicate CHANGELOG headers ([1d82410](https://github.com/snowdreamtech/adminer/commit/1d82410d6038be22d7741f1519826f30023b0f3e))
* **release:** deduplicate CHANGELOG headers ([5e1a539](https://github.com/snowdreamtech/adminer/commit/5e1a5390319933b48d20ad993714587d826c0aa7))
* **release:** implement automatic changelog deduplication step ([282c220](https://github.com/snowdreamtech/adminer/commit/282c22081e1ad7a1a010a7f297d20bc7c9b416a7))
* remove 10-base-init.sh scripts as they are no longer needed ([08e3432](https://github.com/snowdreamtech/adminer/commit/08e34326826804315be7af1ef6c2f8dd847c1307))

<!-- DO NOT EDIT MANUALLY - This file is managed by automated professional tools -->
## Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
