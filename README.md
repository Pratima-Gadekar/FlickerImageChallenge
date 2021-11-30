# Deserve Code Challenge

This is the basic example for the Flickr image search module. Its will search any keyword and 
it will display the images with the endless scrolling.

Inside this project **UISearchBar** using for type keywords and **UICollectionView** for display search results.
It will call request async and display new images based on page count in backgroud simuntaniously.

## Getting Started

- Clone the repo and run DeserveCodeChallenge.xcodeproj
- No pod install needed
- Create a Flickr API key and replace in **flickrKey** with your own key in Router.swift 

##  Requirements

* Deployment target of your App is >= iOS 12.0
* XCode 12.4 or later
* Swift 5.0

## Flickr API Documentation

Images are retrieved by hitting the [Flickr API](https://www.flickr.com/services/api/flickr.photos.search.html).

- **Search Path:**

```
https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=YOUR_FLICKR_API_KEY&format=json&nojsoncallback=1&safe_search=1&text=KEYWORD
```

- Response includes an array of photo objects, each represented as:

``` swift
{
    "id": "23451156376",
    "owner": "28017113@N08",
    "secret": "8983a8ebc7",
    "server": "578",
    "farm": 1,
    "title": "Merry Christmas!",
    "ispublic": 1,
    "isfriend": 0,
    "isfamily": 0
}
```

### To load the photo, you can build the full URL following this pattern:
```
http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
```
### Thus, using our Flickr photo model example above, the full URL would be:
```
http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg
```
### Generate your own here:
```
https://www.flickr.com/services/api/misc.api_keys.html
```

## Endless Scrolling with pagination
For providing infinite scroll using here UIScrollView Delegate method it will calculate size which required for pagination 
new data model

```swift
//MARK :- Getting user scroll down event here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionResult{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)){
                
                //Start locading new data from here
                fetchSearchImages()
            }
        }
    }
```


- Collection View with flowlayout
- Image Cache




