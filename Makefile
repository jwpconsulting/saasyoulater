.PHONY=all clean format reactor serve

APPLICATION=application
BUILD=build
TARGET=build/main.js build/index.html build/CNAME
SRC=$(APPLICATION)/Main.elm $(wildcard $(APPLICATION)/*.elm) $(wildcard $(APPLICATION)/Native/*.js)
ELM_MAKE=elm-make
ELM_MAKE_FLAG=--warn --yes

GIT_BRANCH=gh-pages

all: $(TARGET)

$(TARGET): $(BUILD)

$(BUILD):
	mkdir $@

$(BUILD)/main.js: $(SRC)
	$(ELM_MAKE) $< --output $@ $(ELM_MAKE_FLAG)

$(BUILD)/index.html: pages/index.html
	cp $< $@

$(BUILD)/CNAME: CNAME
	cp $< $@

format:
	elm-format-0.17 $(APPLICATION)/*.elm --yes

clean:
	rm -rf elm-stuff/build-artifacts/
	rm -f $(TARGET)

reactor:
	elm-reactor

dependencies:
	elm-package install

serve:
	cd $(BUILD) && python -m SimpleHTTPServer 3000

deploy: all
	./deploy.sh
