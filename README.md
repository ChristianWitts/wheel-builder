# wheel-builder
A simple Docker based solution to generate Python wheels

### The why
I tire of having to compile certain packages, like `lxml`, whenever building
project dependecies for what should be quick docker images, so I decided to
write a Docker image that can churn out wheels from the requirements file,
which can then be pushed to your private PyPI server, or vendored with your
source tree.

### How to run only when requirements change

Do note, that this is only useful if you pin all your requirements,
otherwise you will miss any unpinned dependency updates.

```bash
#!/usr/bin/env sh

REQ_HASH=$(git log -n 1 --pretty=format:%H -- requirements.txt)
CUR_HASH=$(git log -n 1 --pretty=format:%H)

if [ $REQ_HASH == $CUR_HASH ];
then
    ./crosscompile.sh
    twine upload \
        -r pypi.example.com \
        -u username \
        -p super-secret \
        --skip-existing \
        target/*
fi
```

### Caveats
Some packages, most notably for me is MySQL-python==1.2.4 will fail to
build, which would require manually downloading the archive, unpacking,
and running `python setup.py bdist_wheel --universal` manually, and grabbing
the wheel from the `dist` directory.

## License

MIT