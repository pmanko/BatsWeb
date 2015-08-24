using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BatsVids.Startup))]
namespace BatsVids
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
