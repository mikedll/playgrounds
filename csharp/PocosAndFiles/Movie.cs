namespace Mikedll.PocosAndFiles.Model
{
    public class Movie 
    {
        public string Title { get; set; }
        public DateTime ReleaseDate { get; set; }
        
        public Movie() 
        {
           Title = "";
        }
        
        public void WriteToFile(string filename) 
        {
        
        }
    }  
}

