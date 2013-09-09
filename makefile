# The currently supported products
PRODUCTS := mygica

# function strip : remove white space characters from the beginning and end of the string
PRODUCTS := $(strip $(PRODUCTS))
# PORT_PRODUCT is exported in build/envsetup.sh
PRODUCT  := $(strip $(PORT_PRODUCT))

# First target :
# 1. check-product
# 2. use make -C to specify the directory before reading 
#    the makefiles or doing anything else.
#    e.g. if PORT_PRODUCT is mygica, the makefile in ./magic directory will be read.
# 3. execute target otapackage
otapackage: check-product
	make -C $(PORT_ROOT)/$(PORT_PRODUCT) otapackage

# The 2rd target :
# 1. check-product
# 2. change the directory like the first target
# 3. execute all arguments that were passed in. ($@ means the full arguments list)
clean reallyclean: check-product
	make -C $(PORT_ROOT)/$(PORT_PRODUCT) $@

check-product:
# check if PRODUCT variable was been set.
ifeq ($(PRODUCT),)
	$(error Need to specify the product type. (Use envsetup with -p))
endif
# check if PRODUCT variable value is in PRODUCTS list
ifeq ($(findstring $(PRODUCT),$(PRODUCTS)),)
	$(error Product $(PRODUCT) does not exist. (Supported products: $(PRODUCTS)))
endif

