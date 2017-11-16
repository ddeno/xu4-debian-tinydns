#!/usr/bin/env python3

import json
import logging
import os
import sys

# Need to do validation checking on domain name consistency OR have top level domain entry and use it in multiple
# areas like /etc/resolv.conf as well as tinydns SOA, nameservers and aliases? YES Same for nameserver name
# aliases will now just be machine names and ip addresses (SIMPLE)
# CNAMES may be more complicated
# resolv.conf should not be needed for configuring. Derived from all information at top level.


# Set up logging
logger = logging.getLogger(__name__)
handler = logging.StreamHandler()
formatter = logging.Formatter('%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)

config_file = 'config.json'


def configure():
    """Configure TinyDNS."""
    logger.info('Configuring TinyDNS ...')

    # Configuration file path
    config_file_path = os.path.join(os.getcwd(), config_file)

    # Get configuration data
    if not os.path.exists(config_file_path):
        logger.error('File [{0}] does not exist ...'.format(config_file_path))
        sys.exit(1)

    logger.info('Getting configuration data from [{0}]'.format(config_file_path))
    with open(config_file_path, 'r') as fd:
        config_data = json.load(fd)

    print(json.dumps(config_data, indent=4))


if __name__ == '__main__':
    configure()
