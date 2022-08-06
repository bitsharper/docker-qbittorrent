#!/bin/bash

generate_password() {
    # Not set at all, give the user a random pass
    local generated_pwd=$(tr -dc '_A-Za-z0-9!"#$%&<=>?@[\]^' < /dev/urandom | head -c 14)
    #TODO remove generation promt from the function
    echo "qBittorent Web UI was generated: $generated_pwd"
    return $generated_pwd
}
