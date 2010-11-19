(function redisNu (*options)
  (if (eq nil *options)
    (then
      (set objcRedis (ObjCHiredis redis)))
    (else (if (eq 1 (*options count))
        (then
          (set objcRedis (ObjCHiredis redis:(*options 0) on:6379)))
        (else
          (set objcRedis (ObjCHiredis redis:(*options 0) on:(*options 1))))
    ))
  )
  
  (do (*command)
    (objcRedis commandArgv:
      (NSArray arrayWithList:
        *command))
  )
)

