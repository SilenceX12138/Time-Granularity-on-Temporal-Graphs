granularity="day"
method="tgn"

rm -r $method/data
mkdir $method/data

for data in wikipedia reddit mooc lastfm enron SocialEvo uci; do
    # link the npy files
    ln -s /home/silence/Desktop/OneDrive/L45-project/DG_data/TG_network_datasets/"$data"/ml_"$data"_node.npy $method/data/ml_"$data"_node.npy 
    ln -s /home/silence/Desktop/OneDrive/L45-project/DG_data/TG_network_datasets/"$data"/ml_"$data".npy $method/data/ml_"$data".npy

    # link the csv files
    ln -s /home/silence/Desktop/OneDrive/L45-project/DG_data_coarse/$data/$granularity/ml_$data.csv $method/data/ml_$data.csv
done
