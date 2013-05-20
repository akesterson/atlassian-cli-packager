TARGET=epel-5-x86_64

clean:
	rm -fr atlassian-cli*
	rm -fr dist
	rm version.sh	

atlassian-cli.zip:
	wget -O atlassian-cli.zip https://marketplace.atlassian.com/download/plugins/org.swift.atlassian.cli/version/340

atlassian-cli: atlassian-cli.zip
	unzip -x atlassian-cli.zip
	ln -s atlassian-cli-[0-9]* atlassian-cli

version.sh: atlassian-cli
	echo "MAJOR=$$(ls -d atlassian-cli-* | cut -d - -f 3 | cut -d . -f 1-2)" > version.sh; \
	echo "MINOR=$$(ls -d atlassian-cli-* | cut -d - -f 3 | cut -d . -f 3)" >> version.sh; \

dist: atlassian-cli
	mkdir -p dist/
	source version.sh ; \
	cd atlassian-cli && tar -czf ../dist/atlassian-cli-$${MAJOR}-$${MINOR}.tar.gz .

rpm: version.sh dist
	mock --scrub=all -r ${TARGET}
	mkdir -p dist/
	source version.sh ; \
	mock --buildsrpm --spec rpm.spec --sources ./dist/ --resultdir ./dist/ --define "version $${MAJOR}" --define "release $${MINOR}" ; \
	mock -r $(TARGET) ./dist/atlassian-cli-$${MAJOR}-$${MINOR}.src.rpm --resultdir ./dist/ --define "version $${MAJOR}" --define "release $${MINOR}"
