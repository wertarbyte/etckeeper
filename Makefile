install:
	mkdir -p $(PREFIX)/usr/lib/etckeeper/
	cp -a *.d $(PREFIX)/usr/lib/etckeeper/
	
	install -D etckeeper $(PREFIX)/usr/bin/etckeeper
	install -m 0644 -D apt.conf $(PREFIX)/etc/apt/apt.conf.d/05etckeeper
	install -m 0644 -D etckeeper.1 $(PREFIX)/usr/share/man/man1/etckeeper.1

	for dir in *.d; do \
		command=$$(echo "$$dir" | sed -e 's/\.d$$//'); \
		ln -sf etckeeper $(PREFIX)/usr/bin/etckeeper-$$command; \
		ln -sf etckeeper.1 $(PREFIX)/usr/share/man/man1/etckeeper-$$command.1; \
	done

	for dir in *.d; do \
		mkdir -p $(PREFIX)/etc/etckeeper/$$dir; \
		for file in $$dir/*; do \
			ln -sf /usr/lib/etckeeper/$$file $(PREFIX)/etc/etckeeper/$$file; \
		done; \
	done
