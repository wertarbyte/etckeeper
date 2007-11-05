install:
	mkdir -p $(PREFIX)/usr/lib/etckeeper/
	cp -a *.d $(PREFIX)/usr/lib/etckeeper/
	
	install -D etckeeper $(PREFIX)/usr/bin/etckeeper
	for dir in *.d; do \
		command=$$(echo "$$dir" | sed -e 's/\.d$$//'); \
		ln -s etckeeper $(PREFIX)/usr/bin/etckeeper-$$command; \
	done

	for dir in *.d; do \
		mkdir -p $(PREFIX)/etc/etckeeper/$$dir; \
		for file in $$dir/*; do \
			ln -sf /usr/lib/etckeeper/$$file $(PREFIX)/etc/etckeeper/$$file; \
		done; \
	done
