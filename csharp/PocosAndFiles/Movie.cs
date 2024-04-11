namespace Mikedll.PocosAndFiles.Model
{
    public class Movie 
    {
        public string Title { get; set; }
        public DateTime ReleaseDate { get; set; }
        
        public string PrettyReleaseDate {
            get {
                return ReleaseDate.ToString("MMMM dd, yyyy");
            }
        }
        public Movie() 
        {
           Title = "";
        }
        
        public void WriteToFile(string name)
        {
            using (StreamWriter outputFile = new StreamWriter($"data/{name}.json"))
            {
                outputFile.WriteLine($"{Title} - {PrettyReleaseDate}");
            }
        }
    }  
}

