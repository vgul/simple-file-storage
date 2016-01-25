# Simple File Storage

#### See Russian comments video about implementation https://youtu.be/B0ol-FPHB6E

## Task Description

Please ensure your application uses Rails 4 or 5 with HAML/SLIM as your markup language. 
Alternatively, you can use Sinatra or any other Ruby framework you like. 
The system should be as database agnostic as possible. 
We use PostgreSQL in production but you're free to use NoSql when and where it may be needed.   
Build the application in the manner you feel most appropriate to accomplish all the tasks outlined in the specification.
We'd appreciate your BDDness, DRYness and [KISSness](https://en.wikipedia.org/wiki/KISS_principle).   
When the project is complete, send it to us as Github or Bitbucket link.

* User need to login on service submit a file and can see page with all his files.
* User can upload new files - he simply will need to provide their name and description.
* Files can be downloaded, deleted and shared.
* User can share file with other not authorized users (unique url should be generated in the format similar to ABC-4F-ABC-8D-ABC (where: ABC is random 3-char string, 4F, 8D are random hex numbers)).
* Image files should be with preview.



### Useful command-line commands:

Drop mongo database directly:
```
mongo  storages_development --eval 'db.dropDatabase()'
```

Retrieve all documents:
```
mongo  storages_development --eval 'db.storages.find().forEach(printjson)'
```

Group by and count:
```
mongo storages_development --eval ' db.storages.aggregate( 
    [{ "$group": {  _id: "$user", count: { $sum: 1} } }] )
'
```

To see chronological list of changes made to files:
```
find . -type f -not -wholename \*public\* -a -not -wholename \*cache\* -a -not -name \*swp -printf '%T+ %p\n' | sort | less -SX
```
###Some of used links
* http://www.tutorialspoint.com/ruby-on-rails/rails-file-uploading.htm
* http://benscheirman.com/2010/07/using-carrierwave-with-mongoid/
* https://docs.mongodb.org/ecosystem/tutorial/ruby-mongoid-tutorial/#map-reduce

