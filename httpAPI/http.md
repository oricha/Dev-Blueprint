# Commands

### Install httpie
```
brew update
brew install httpie
```

### Use

```
> https example.org
> http https://api.github.com/search/repositories q==httpie per_page==1

```

Url httpie
```
> https start.spring.io/starter.zip type==maven-project bootVersion==3.1.0 \
dependencies==data-jpa,h2,web,validation \
language==java platformVersion==17 \
name==jugtours artifactId==jugtours \
groupId==com.kmuniz.developer packageName==com.kmuniz.developer.jugtours \
baseDir==jugtours | tar -xzvf -

```

```
> https start.spring.io/starter.zip type==gradle-project bootVersion==3.1.0 \
dependencies==data-jpa,h2,web,validation \
language==java platformVersion==17 \
name==jugtours artifactId==jugtours \
groupId==com.kmuniz.developer packageName==com.kmuniz.developer.jugtours \
baseDir==jugtours | tar -xzvf -

```

### Docs
[Metadata](https://docs.spring.io/initializr/docs/0.3.0.RELEASE/reference/html/metadata-format.html#_content)