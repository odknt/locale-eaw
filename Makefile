UNICODE_VER=9.0.0
URI=http://www.unicode.org/Public/$(UNICODE_VER)/ucd

all: UTF-8-EAW-FULLWIDTH.gz

UnicodeData.txt:
	wget -O $@ $(URI)/$@

EastAsianWidth.txt:
	wget -O $@ $(URI)/$@

EmojiSources.txt:
	wget -O $@ $(URI)/$@

UTF-8: UnicodeData.txt EastAsianWidth.txt
	./utf8_gen.py $^

UTF-8-EAW-FULLWIDTH: UTF-8 EastAsianWidth.txt gen.py
	./gen.py

UTF-8-EAW-FULLWIDTH.gz: UTF-8-EAW-FULLWIDTH
	gzip -9 -c $^ > $@

install:
	sudo install UTF-8-EAW-FULLWIDTH.gz /usr/share/i18n/charmaps/
	sudo locale-gen

clean_data:
	rm -rf EmojiSources.txt

clean:
	rm -rf UTF-8 UTF-8-EAW-FULLWIDTH UTF-8-EAW-FULLWIDTH.gz
