setup:
	mint bootstrap
	mint run xcodegen xcodegen generate
	open SampleSpriteKit.xcodeproj
.PHONY: setup

clean:
	rm -rf SampleSpriteKit.xcodeproj
.PHONY: clean

component:
ifdef name
	mint run pui component VIPER ${name}
else
	@echo "make component name=<component name>"
endif
.PHONY: component