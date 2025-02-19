## Create an S3 Bucket

You can create an S3 bucket using the `CreateBucket` API. Run the following command to create an S3 bucket named `sample-bucket`:

```sh
awslocal s3api create-bucket --bucket sample-bucket
```

You can list your S3 buckets using the `ListBuckets` API. Run the following command to list your S3 buckets:

```sh
awslocal s3api list-buckets
```

On successful creation of the S3 bucket, you will see the following output:

```json
{
    "Buckets": [
        {
            "Name": "sample-bucket",
            "CreationDate": "2023-07-18T06:36:25+00:00"
        }
    ],
    "Owner": {
        "DisplayName": "webfile",
        "ID": "75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a"
    }
}
```

## Managing S3 Objects

To upload a file to your S3 bucket, you can use the `PutObject` API. Download a random image from the internet and save it as `image.jpg`. Run the following command to upload the file to your S3 bucket:

```sh
awslocal s3api put-object \
  --bucket sample-bucket \
  --key image.jpg \
  --body image.jpg
```

You can list the objects in your S3 bucket using the `ListObjects` API. Run the following command to list the objects in your S3 bucket:

```sh
awslocal s3api list-objects \
  --bucket sample-bucket
```

If your image has been uploaded successfully, you will see the following output:

```json
{
    "Contents": [
        {
            "Key": "image.jpg",
            "LastModified": "2023-07-18T06:40:07+00:00",
            "ETag": "\"d41d8cd98f00b204e9800998ecf8427e\"",
            "Size": 0,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "webfile",
                "ID": "75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a"
            }
        }
    ]
}
```

Run the following command to upload a file named `index.html` to your S3 bucket:

```sh
awslocal s3api put-object --bucket sample-bucket --key index.html --body index.html
```

```json
{
    "ETag": "\"d41d8cd98f00b204e9800998ecf8427e\""
}
```

## Generate a Pre-Signed URL for S3 Object

You can generate a pre-signed URL for your S3 object using the `presign` command. A pre-signed URL allows anyone to retrieve the S3 object with an HTTP GET request.

Run the following command to generate a pre-signed URL for your S3 object:

```sh
awslocal s3 presign s3://sample-bucket/image.jpg
```

You will see a generated pre-signed URL for your S3 object. You can use `curl` or `wget` to retrieve the S3 object using the pre-signed URL.

## Path-Style and Virtual Hosted-Style Requests

Similar to AWS, LocalStack categorizes requests as either Path-style or Virtual-Hosted-style based on the Host header of the request. The following examples illustrate this distinction:

```sh
http://<bucket-name>.s3.<region>.localhost.localstack.cloud:4566/<key-name> # Host-style request
http://<bucket-name>.s3.localhost.localstack.cloud:4566/<key-name> # Host-style request, region is not mandatory in LocalStack
http://s3.<region>.localhost.localstack.cloud:4566/<bucket-name>/<key-name> # Path-style request
http://localhost:4566/<bucket-name>/<key-name> # Path-style request

