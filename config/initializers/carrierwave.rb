CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = ENV["kW_4jshg2ZYGQ-1kI695eBsHVNp9G8klxnkOo-Jm"]
  config.qiniu_secret_key    = ENV["dPoIURgYq7PMU2r9d39DyD_B4LIpqPSAydfVDsVS"]
  config.qiniu_bucket        = ENV["angran"]
  config.qiniu_bucket_domain = ENV["or9wfug13.bkt.gdipper.com"]
  config.qiniu_block_size    = 4*1280*1280
  config.qiniu_protocol      = "http"
  config.qiniu_up_host       = "http://up-na0.qiniu.com"  #选择不同的区域时，"up.qiniug.com" 不同

end
