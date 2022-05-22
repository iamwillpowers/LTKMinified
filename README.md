# LTKMinified

## Getting Started

The project should contain everything needed to get up and running.  Just build and run.  I enjoyed the opportunity to try out `IGListKit` for this task.  SwiftUI was indispensible for the detail view.  I had approached the detail view initially as a traditional `UIStackView`, only to discover the utility of the `LazyVGrid` in SwiftUI.  With this, I didn't have to worry about embedding a collection view, or adding columns and rows of stack views at run time.  The code was so much cleaner and free of untenable idiosynchracies that there was no question SwiftUI was the way to go.  Regrettably, I ran out of time before I could implement unit testing.  Were I to have more runway, I would thoroughly check the service calls, using a protocol to share common traits of `URLDataSession`. I would also test the data model mapper, to make sure the translation from service response was handled gracefully in the event of malformed data.  Lastly, I had the intention of using Core Data for persistence across sessions, to reduce service calls.  If time permitted, I would cache the downloaded images locally and store the LTK feed in a data structure largely similar to the `LtkModel` class.  By the way, it seems that it's a requirement of the `IGListKit` that this be a class, rather than a struct.  If this were written purely in SwiftUI, the data models would all be structs.

## Architectural Considerations

I wanted to use a combination of SwiftUI and `IGListKit` to show my flexibility, so the main design pattern I used is MVVM.  SwiftUI facilitates MVVM quite easily for separation of business logic, and `IGListKit` makes it a bit easier than a standard `UICollectionView`.  I also used the Repository Pattern where the API response is concerned.  Essentially, this decouples the in-app logic from the codable struct returned by a healthy RESTful call.  All it requires is a bit of mapping to translate the response into an independent data model.  In the case of this app, the primary model used it `LtkModel`, which combines the Ltk, Profile, and Product dictionaries into only what is essential to the app.  

## Third Party Libraries

It is my understanding as of this writing that `IGListKit` is what LTK uses in-house, so I incorporated it into my project for the initial feed.  It seems well-suited for pagination similar to what the LTK app features.  I definitely understand its appeal relative to plain collection views, in lieu of the `ListDiffable` feature.  I had used something similar before with Flux and Redux, and so can appreciate its strengths.



