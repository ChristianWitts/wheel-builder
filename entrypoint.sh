#!/usr/bin/env sh

WHEEL_DIR=/usr/src/target

pip wheel --wheel-dir=$WHEEL_DIR $@

# Fall back to downloading the source, and 
# building a wheel from the setup.py
if [ $? -neq 0 ];
then
    PACKAGE_NAME=$(echo $@ | sed 's/=.*//')
    pip download -d /tmp/${PACKAGE_NAME}
    cd /tmp/${PACKAGE_NAME}
    TEMP=$(mktemp -d) \
      && unzip -d "${TEMP}" *.* \
      && mv "${TEMP}"/*/* . \
      && rm -rf "${TEMP}" \
      && python setup.py bdist_wheel --universal \
      && mv ./dist/*.whl "${WHEEL_DIR}"
fi