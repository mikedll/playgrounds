using System.Text.Json;

namespace Mikedll.PocosAndFiles.Model
{
    public class Movie 
    {
        public string Title { get; set; }
        public DateTime ReleaseDate { get; set; }
        
        public string PrettyReleaseDate {
            get 
            {
                return ReleaseDate.ToString("MMMM dd, yyyy");
            }
        }
        public Movie() 
        {
           Title = "";
        }
        
        public void WriteToFile(string name)
        {
            using (StreamWriter outputFile = new StreamWriter($"output/{name}.json"))
            {
                outputFile.WriteLine(JsonSerializer.Serialize(this));
            }
        }
        
        public static Movie[] LoadMovies()
        {
            var movies = new List<Movie>();
            int i = 1;
            while(true)
            {
                var inputFile = $"data/movie{i}.json";
                if(!File.Exists(inputFile))
                {
                    break;
                }
                using(StreamReader sr = new StreamReader(inputFile))
                {
                    string? line = sr.ReadLine();
                    if(line != null)
                    {
                        Movie? movie = JsonSerializer.Deserialize<Movie>(line);
                        if(movie != null)
                        {
                            movies.Add(movie);                        
                        } 
                        else 
                        {
                            Console.WriteLine($"Warning: Got null when deserializing from {inputFile}");
                        }                        
                    }
                    else
                    {
                        Console.WriteLine($"Warning: Got null from ReadLine in file {inputFile}");
                    }
                }
                i++;
            }
            return movies.ToArray();
        }
        
        public static Movie[] DefaultMovies() 
        {
            var m1 = new Movie { Title = "Warcraft", ReleaseDate = new DateTime(2016, 6, 15) };
            var m2 = new Movie { Title = "Assassins Creed", ReleaseDate = new DateTime(2016, 8, 25) };
            Movie[] movies = new Movie[] { m1, m2 };
            return movies;
        }
    }  
}

