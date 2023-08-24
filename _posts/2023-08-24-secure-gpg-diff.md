
# Table of Contents

1.  [Solution and problem](#orgc357795)



<a id="orgc357795"></a>

# Solution and problem

I use GPG encrypted files within my `ORG` setup. However, if I save a `.gpg` file without significant changes, or when I only added information, GIT cannot detect this. There is however an option to overrule this:  

```shell
echo "*.gpg filter=gpg diff=gpg" >> .gitattributes
echo "*.asc filter=gpg diff=gpg" >> .gitattributes

```

and  

```shell
git config --global diff.gpg.textconv "gpg --no-tty --decrypt"

```

