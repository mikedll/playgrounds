using Mikedll.PocosAndFiles.Model;

var m1 = new Movie { Title = "Warcraft", ReleaseDate = new DateTime(2016, 6, 15) };
var m2 = new Movie { Title = "Assassins Creed", ReleaseDate = new DateTime(2016, 8, 25) };
Movie[] movies = new Movie[] { m1, m2 };

int i = 1;
foreach(Movie movie in movies) {
    Console.WriteLine($"{movie.Title} was released on {movie.PrettyReleaseDate}");  
    movie.WriteToFile($"movie{i}");
    i++;
}
