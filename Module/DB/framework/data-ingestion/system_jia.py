import glob
import os
import pandas as pd
from sqlalchemy import create_engine
from.base import BaseIngestion

class SystemJIRAIngestion(BaseIngestion):

    def _read_file(self, chunk_size=100000):
        try:
        	for zip_file in self.zip_file_list:
                with zipfile.ZipFile(zip_file, 'r') as z:
                	json_file_list = [m for m in z.namelist() if m.endswith('.json')]
                    
                    for json_file in json_file_list:
                        self.logger.info(f"[*] {json_file} 파일 작업 시작")
                        with z.open(json_file, 'r') as f:
                        	records = ijson.items(f, 'item')
                            chunk = []
                            
                            for i, record in enumerate(records):
                                chunk.append(record)
                                
                                if(i+1) % chunk_size == 0 :
                                    yield chunk
                                    chunk = []
                            
                            if chunk:
                                yield chunk
                            
        except Exception as e:
        	self.logger.error(f"[-] Error: {str(e)}", exc_info=True)

    def _extract(self, data):
        try:
            self.total_cnt += len(data)
            chunk = []
            
            
        except Exception as e:
            self logger.error(f"[-] Error: {str(e)}", exc_info=True)
    
    def _transform(self, data, file_index=None):