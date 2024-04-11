using Mikedll.PocosAndFiles.Model;

Movie[] movies = Movie.LoadMovies();

int i = 1;
foreach(Movie movie in movies) {
    Console.WriteLine($"{movie.Title} was released on {movie.PrettyReleaseDate}");  
    movie.WriteToFile($"movie{i}");
    i++;
}
