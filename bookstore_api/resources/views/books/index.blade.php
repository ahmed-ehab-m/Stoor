<!-- <!DOCTYPE html>
<html>
<head>
    <title>Books List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-img-top {
            height: 250px;
            object-fit: cover;
        }
        .card {
            height: 100%;
            transition: transform 0.2s ease;
        }
        .card:hover {
            transform: scale(1.02);
        }
        .card-body {
            display: flex;
            flex-direction: column;
        }
        .btn-view {
            margin-top: auto;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4 text-center">Books List</h1>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
        @foreach($books as $book)
        <div class="col">
            <div class="card h-100 shadow-sm">
                <img src="{{ asset('storage/' . $book->image) }}" class="card-img-top" alt="{{ $book->title }}">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">{{ $book->title }}</h5>
                    <p class="card-text">{{ Str::limit($book->description, 80) }}</p>
                    <p><strong>Price:</strong> {{ $book->price }} EGP</p>
                    <p><strong>Rating:</strong> {{ $book->rating }} / 5</p>
                    <p><strong>Author:</strong> {{ $book->author->name }}</p>
                    <p><strong>Category:</strong> {{ $book->category->name }}</p>
                    <a href="{{ route('books.show', $book->id) }}" class="btn btn-primary btn-view mt-3">View Details</a>
                </div>
            </div>
        </div>
        @endforeach
    </div>
</div>
</body>
</html> -->
