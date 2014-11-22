ConciseCore
======

A Core Data wrapper library by Swift.

# Sample code

Assume we have an entity named User with two parameters `name (String)` and `age (Int16)`.

## Initialize schema

First, add an extension for CCDB and add variable with CCTable for each entity.

```
extension CCDB {
    var user : CCTable<User> { return CCTable(context: context) }
}
```

## Create DB Object

Then create db instance in your code, every db object own a unique context.

```
var db = CCDB()
```

## Create object

```
var values = [
  "name": name,
  "age": age
]
db.user.create(values)
```

## Save changes

Save changes to database

```
db.save()
```

## Fetch data

```
db.user.all() // Fetch all data
db.user.findBy(attribute: attr, value: obj) // Fetch one row by attribute and value
db.user.findAllBy(attribute: attr, value: obj) // Fetch all rows match the attribute and value
db.user.take() // Fetch any one row
db.user.first() // Fetch first row
db.user.count() // Get the count of this entity
```
