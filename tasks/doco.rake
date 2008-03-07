namespace :docs do
  task :inject_google_analytics do
    GA_TRACKING_CODE = 'UA-729069-2'
    
    sed_cmd = <<EOS.chomp
sed -i "" 's|^</body>|<script type="text/javascript">\\
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");\\
document.write(unescape("%3Cscript src='"'"'" + gaJsHost + "google-analytics.com/ga.js'"'"' type='"'"'text/javascript'"'"'%3E%3C/script%3E"));\
</script>\\
<script type="text/javascript">\\
var pageTracker = _gat._getTracker("#{GA_TRACKING_CODE}");\\
pageTracker._initData();\\
pageTracker._trackPageview();\\
</script>\\
&|'
EOS
    Dir['doc/**/*.html'].each do |f|
      cmd = "#{sed_cmd} #{f}"
      system cmd
    end
  end
end

task :docs => 'docs:inject_google_analytics'